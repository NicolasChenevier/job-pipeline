create table raw_jobs (
  id bigserial primary key,
  source text not null,
  payload jsonb not null,
  scraped_at timestamptz default now()
);

create table jobs (
  id bigserial primary key,
  source text not null,
  source_url text not null unique,
  role text,
  company text,
  location text,
  work_mode text,
  salary_raw text,
  description text,
  match_score int,
  matched_keywords text[],
  posted_at timestamptz,
  scraped_at timestamptz default now()
);

create table job_status (
  job_id bigint primary key references jobs(id) on delete cascade,
  estado text not null default 'pendiente',
  motivo text,
  updated_at timestamptz default now()
);

create table scrape_runs (
  id bigserial primary key,
  source text not null,
  started_at timestamptz default now(),
  finished_at timestamptz,
  jobs_inserted int,
  status text
);