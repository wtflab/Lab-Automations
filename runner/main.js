import express, { json } from "express";
import dotenv from "dotenv";
import { RunnerService } from "./runner.service.js";
import { middleware } from "./middleware.js";

dotenv.config();
const app = express();
const PORT = process.env.PORT;

app.use(json());
app.use(middleware);

app.post("/automation", async (req, res) => {
  const files = req.body?.files ?? "";

  const testResults = await RunnerService.runTests(files);
  const formatterResults = await RunnerService.runFormatter(files);
  const linterResults = await RunnerService.runLinter(files);

  res.status(200).json({
    message: "OK",
    result: {
      testResults,
      formatterResults,
      linterResults,
    },
  });
});

app.listen(PORT, () => {
  console.log(`Server works on ${PORT}`);
});
