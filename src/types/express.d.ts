declare global {
  namespace Express {
    interface User {
      id: string;
      email?: string;
      role?: "admin" | "user" | string;
    }

    interface Request {
      user?: User;
    }
  }
}

export {};
