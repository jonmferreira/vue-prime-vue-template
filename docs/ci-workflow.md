# Continuous Integration Workflow

This repository ships a GitHub Actions workflow located at [`.github/workflows/ci.yml`](../.github/workflows/ci.yml).
It is triggered for every pull request that targets the `main` branch and is split into multiple jobs that cooperate
through conditional execution, caching, and shared artifacts.

## Job overview

```text
Detect Changes ──┐
                 ├─▶ Prepare Dependencies ──┐
                 │                          ├─▶ Build
                 │                          ├─▶ Lint
                 │                          └─▶ Tests
```

### Detect Changes (`changes`)
* **Purpose**: Decide whether the remaining jobs should run.
* **Key logic**: Uses [`dorny/paths-filter`](https://github.com/dorny/paths-filter) to check if the pull request touched any of the
  monitored paths (`src/**`, `package.json`, lockfiles, Vite and TypeScript configs).
* **Outcomes**:
  * When no relevant files change, the rest of the workflow is skipped without failing the pipeline.
  * When dependency manifests change, the information is propagated so `npm ci` can be re-run.
* **Reporting**: Writes a short Markdown summary into the job summary panel.

### Prepare Dependencies (`dependencies`)
* **Purpose**: Provide a warmed `node_modules` directory for downstream jobs.
* **Cache behaviour**:
  * Restores a cache keyed by the current `package-lock.json` hash.
  * Runs `npm ci` only when the cache misses *or* dependency manifests changed in the pull request.
  * Publishes the directory as a short-lived artifact (`node-modules`) so other jobs can reuse it.
* **Reporting**: Always appends a status update to the job summary with cache hit/miss details.

### Build, Lint, and Tests
* **Purpose**: Validate the project in parallel once the prerequisites are satisfied.
* **Shared setup**:
  * Depend on both previous jobs and only run when `Detect Changes` marked the pull request as relevant.
  * Restore the `node-modules` artifact produced by `Prepare Dependencies` instead of reinstalling packages.
* **Commands**:
  * `Build`: runs `npm run build`.
  * `Lint`: runs `npm run lint`.
  * `Tests`: runs `npm test --if-present` (so the job passes even when no test script exists).
* **Reporting**: Each job posts a success/failure note to its summary so reviewers can see the result at a glance.

## Skipping behaviour
When a pull request only changes documentation or other non-monitored files, the workflow exits after the
`Detect Changes` job. GitHub marks the skipped jobs as "skipped" (not failed), providing fast feedback without wasting
compute minutes.

## Adding richer summaries
Job summaries accept static Markdown, so you can embed screenshots or other generated artifacts using standard
Markdown image syntax. To showcase a running build, generate a screenshot during the job, upload it as an artifact (or
store it within the workspace), and reference it from the summary. Streaming console output or an interactive preview
is not supported.
