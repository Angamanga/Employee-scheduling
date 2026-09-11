import "dotenv/config";
import express from "express";
import { authRouter } from "./routes/auth.js";

const app = express();
app.use(express.json());
const PORT = 3000;

// Auth-routes
app.use("/api/auth", authRouter);

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
