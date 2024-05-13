import express, { json } from "express";
import dotenv from "dotenv";
import { RunnerService } from "./runner.service.js";

dotenv.config();
const app = express();
const PORT = process.env.PORT;

app.use(json({ limit: "10mb" }));

app.post("/automation/tasks/test", async (req, res) => {
  const files = req.body?.files ?? "";

  const failedTests = await RunnerService.runTests(files);
  res.status(200).json({
    message: "OK",
    result: failedTests,
  });
});

app.post("/automation/formatter", async (req, res) => {
  const archive = req.body.archive;

  const formatterResults = await RunnerService.runFormatter(archive);
  res.status(200).json({
    message: "OK",
    result: formatterResults,
  });
});

app.post("/automation/linter", async (req, res) => {
  const archive = req.body?.archive;

  const linterResults = await RunnerService.runLinter(archive);
  res.status(200).json({
    message: "OK",
    result: linterResults,
  });
});

app.listen(PORT, () => {
  console.log(`Server works on ${PORT}`);
});
