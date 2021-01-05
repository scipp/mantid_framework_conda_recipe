import subprocess
import argparse

def git_version_str(major, minor):
    commit_id = subprocess.check_output(["git", "rev-parse", "HEAD"]).decode("utf-8")
    version = subprocess.check_output(
        ["git", "log", "-1", "--pretty='%ad'",
         f"--date=format:'{major}.{minor}.%Y%m%d.%H%M'"]).decode("utf-8")
    return commit_id.strip(), version.strip().replace("'", "")


if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='This script generated the mantid version to use for packaging', prog='builder')
    positional_args = parser.add_argument_group('Positional arguments')
    positional_args.add_argument('major', nargs='?', type=int, help='The mantid Major Version')
    positional_args.add_argument('minor', nargs='?', type=int, help='The mantid Minor Version')
    arguments = parser.parse_args()
    commit_id, version = git_version_str(arguments.major, arguments.minor)
    block = '\n=================================================\n'
    message = f'{block}Compute version string{block}' \
      f'Mantid Major version {arguments.major}\n' \
      f'Mantid Minor version {arguments.minor} and\n' \
      f'Commit id associated with HEAD' \
      f'{block}{commit_id}{block}' \
      f'Yields mantid version string' \
      f'{block}{version}{block}'
    print(message)
