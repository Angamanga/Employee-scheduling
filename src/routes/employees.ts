import { Router } from "express";
import type { Request, Response } from "express";
import { PrismaClient } from "../../generated/prisma/client.js";
import type { User } from "../../generated/prisma/client.js";
import { PrismaPg } from "@prisma/adapter-pg";
import { requireAdmin } from "../middleware/auth.js";

const adapter = new PrismaPg({ connectionString: process.env.DATABASE_URL });
const prisma = new PrismaClient({ adapter });

export const employeeRouter = Router();
// Endpoint to get all employees, ADMIN required

employeeRouter.get("/", requireAdmin, async (req: Request, res: Response) => {
  try {
    const users: User[] = await prisma.user.findMany();
    if (!users) {
      return res.status(404).json({ message: "No users found" });
    }
    console.log(`${users.length} user(s) found`);

    return res
      .status(200)
      .json({ message: `${users.length} user(s) found`, users });
  } catch (err) {
    console.log(`An error happened! ${err}`);
    return res.status(500).json({ message: "Oh no internal server error!!!" });
  }
});
