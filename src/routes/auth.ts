import { Router } from "express";
import type { Request, Response } from "express";
import { PrismaClient, Role } from "../../generated/prisma/client.js";
import type { Employee, User } from "../../generated/prisma/client.js";
import { PrismaPg } from "@prisma/adapter-pg";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";

const adapter = new PrismaPg({ connectionString: process.env.DATABASE_URL });
const prisma = new PrismaClient({ adapter });

export const authRouter = Router();

authRouter.post("/register", async (req: Request, res: Response) => {
  try {
    // TODO: Add zod-validation
    const { firstname, lastname, email, password } = req.body;
    const existingUser: User | null = await prisma.user.findUnique({
      where: { Email: email.toLowerCase() },
    });

    if (existingUser)
      return res.status(400).json({ message: "User already exists" });

    const hashedPassword = await bcrypt.hash(password, 10);

    const employee: Employee = await prisma.employee.create({
      data: {
        Firstname: firstname,
        Lastname: lastname,
      },
    });

    if (!employee.id) {
      res.status(500).json({ message: "Could not create user" });
      return;
    }
    console.log(`New employee created: ${employee.id}`);

    const newUser: User = await prisma.user.create({
      data: {
        Role: Role.EMPLOYEE,
        LoginCode: hashedPassword,
        Email: email.toLowerCase(),
        EmployeeID: employee.id,
      },
    });

    console.log(`New user created: ${newUser.id}`);
    res.status(201).json({ message: "User created successfully" });
  } catch (err) {
    console.log(err);
    res.status(500).json({ message: "Server error" });
  }
});

authRouter.post("/login", async (req: Request, res: Response) => {
  try {
    // TODO: Add zod-validation
    const { email, password } = req.body;

    const user: User | null = await prisma.user.findUnique({
      where: { Email: email.toLowerCase() },
    });
    if (!user) return res.status(400).json({ message: "Invalid credentials" });

    const isMatch: boolean = await bcrypt.compare(password, user.LoginCode);
    if (!isMatch) {
      res.status(401).json({ error: "Invalid email or password." });
      return;
    }

    const payload: { id: number; email: string } = {
      id: user.id,
      email: user.Email,
    };

    const jwtSecret: string | undefined = process.env.JWT_SECRET;
    if (!jwtSecret) {
      res.status(500).json({ message: "JWT secret is not configured" });
      return;
    }

    const token: string = jwt.sign(payload, jwtSecret, { expiresIn: "15m" });
    res.json({ token });
  } catch (err) {
    console.log(err);
    res.status(500).json({ message: "Server error" });
  }
});
