# User
default['gitlab']['production']['user'] = "git"
default['gitlab']['production']['group'] = "git"
default['gitlab']['production']['home'] = "/home/git"

# GitLab shell
default['gitlab']['production']['shell_path'] = "/home/git/gitlab-shell"

# GitLab hq
default['gitlab']['production']['revision'] = "6-1-stable"
default['gitlab']['production']['path'] = "/home/git/gitlab"

# GitLab shell config
default['gitlab']['production']['repos_path'] = "/home/git/repositories"

# GitLab hq config
default['gitlab']['production']['satellites_path'] = "/home/git/gitlab-satellites"

# Setup environments
default['gitlab']['production']['environments'] = %w{production}
