import jwt from "jsonwebtoken";
import type { NextFunction, Request, Response } from "express";
import { Role } from "../../generated/prisma/client.js";

export const requireAuth = (
  req: Request,
  res: Response,
  next: NextFunction,
) => {
  const authHeader = req.headers.authorization || "";
  const [scheme, token] = authHeader.split(" ");
  if (scheme !== "Bearer" || !token) {
    return res
      .status(401)
      .json({ message: "Missing or invalid Authorization header" });
  }
  try {
    const secret = process.env.JWT_SECRET;
    if (!secret) {
      console.log("JWT_SECRET is missing");
      return res.status(500).json({ message: "Oops a server error happened" });
    }
    const decoded = jwt.verify(token, secret);
    // TODO: Probably remove once zod-validation is in place?
    if (
      typeof decoded === "string" ||
      typeof decoded.id !== "number" ||
      typeof decoded.email !== "string" ||
      (decoded.role !== Role.ADMIN && decoded.role !== Role.EMPLOYEE)
    ) {
      return res.status(401).json({ message: "Invalid token" });
    }
    req.user = {
      id: decoded.id,
      email: decoded.email,
      role: decoded.role,
    };
    next();
  } catch (error) {
    console.log(error);
    if (error instanceof jwt.TokenExpiredError) {
      return res.status(401).json({ message: "Access token expired" });
    }
    return res.status(401).json({ message: "Invalid token" });
  }
};

export const requireAdmin = (
  req: Request,
  res: Response,
  next: NextFunction,
) => {
  requireAuth(req, res, () => {
    if (!req.user || req.user.role !== Role.ADMIN) {
      return res.status(403).json({ message: "Admin access required" });
    }
    next();
  });
};
