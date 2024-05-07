import express, { json } from "express";
import { RunnerService } from "./runner.service.js";

const app = express();
const PORT = 3001;

app.use(json());

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
