export function middleware(req, res, next) {
  const runnerToken = process.env.RUNNER_TOKEN;
  const requestToken = req.headers["x-api-key"];

  if (requestToken !== runnerToken) {
    return res.status(401).send("Unauthorized");
  }

  next();
}
