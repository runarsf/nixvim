#! /usr/bin/env cached-nix-shell
#! nix-shell -i python3 -p python3Packages.requests python3Packages.humanize

import requests
import json
import humanize
import os
import argparse
from datetime import datetime

def get_commit(repo_owner, repo_name, sha, token):
    url = f"https://api.github.com/repos/{repo_owner}/{repo_name}/commits/{sha}"
    headers = {
        'Authorization': f"token {token}",
        'Accept': 'application/vnd.github+json',
        'X-GitHub-Api-Version': '2022-11-28'
    }
    response = requests.get(url, headers=headers)
    commit_data = response.json()
    return commit_data

def get_commits(repo_owner, repo_name, start_sha, token):
    since_datetime = get_commit(repo_owner, repo_name, start_sha, token)['commit']['committer']['date']
    url = f"https://api.github.com/repos/{repo_owner}/{repo_name}/commits"
    headers = {
        'Authorization': f"token {token}",
        'Accept': 'application/vnd.github+json',
        'X-GitHub-Api-Version': '2022-11-28'
    }
    params = {
        'since': since_datetime,
        'per_page': 100,
        'path': '/plugins'
    }
    all_commits = []

    while url:
        response = requests.get(url, headers=headers, params=params)
        commits = response.json()
        all_commits.extend(commits)
        url = response.links.get('next', {}).get('url')

    return all_commits

def get_commit_files(user, repo, commit_sha, token):
    commits = get_commits(user, repo, commit_sha, token)
    headers = {
        'Authorization': f"token {token}",
        'Accept': 'application/vnd.github+json',
        'X-GitHub-Api-Version': '2022-11-28'
    }
    files = []
    for commit in commits:
        try:
            commit_details = requests.get(commit['url'], headers=headers).json()
        except requests.exceptions.ConnectionError:
            continue

        files = commit_details.get('files', [])
        commit_time = datetime.strptime(commit['commit']['committer']['date'], '%Y-%m-%dT%H:%M:%SZ')
        time_ago = humanize.naturaltime(datetime.now() - commit_time)

        for file in files:
            if file['status'] != 'added':
                continue
            if not file['filename'].startswith('plugins/'):
                continue

            print(f"{file['filename']} ({time_ago})")
            files.append(file['filename'])

    if len(files) <= 0:
        print("No new plugins found")


locked_commit_sha = None
if os.path.isfile("flake.lock"):
    with open("flake.lock", "r") as lockfile:
        locked_commit_sha = json.load(lockfile)['nodes']['nixvim']['locked']['rev']

parser = argparse.ArgumentParser(description='List plugin releases')

parser.add_argument('commit_sha', nargs='?', type=str, help='The commit SHA to start from, defaults to locked sha', default=locked_commit_sha)
parser.add_argument('-t', '--token', type=str, help='GitHub API token', default=os.getenv('GITHUB_TOKEN', None))

args = parser.parse_args()

if args.token is None:
    print("Please provide a GitHub token")
    exit(1)

get_commit_files('nix-community', 'nixvim', args.commit_sha, args.token)
