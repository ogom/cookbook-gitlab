# User
default['gitlab']['development']['user'] = "vagrant"
default['gitlab']['development']['group'] = "vagrant"
default['gitlab']['development']['home'] = "/home/vagrant"

# GitLab shell
default['gitlab']['development']['shell_path'] = "/vagrant/gitlab-shell"

# GitLab hq
default['gitlab']['development']['revision'] = "master"
default['gitlab']['development']['path'] = "/vagrant/gitlab"

# GitLab shell config
default['gitlab']['development']['repos_path'] = "/vagrant/repositories"

# GitLab hq config
default['gitlab']['development']['satellites_path'] = "/vagrant/gitlab-satellites"

# Setup environments
default['gitlab']['development']['environments'] = %w{development test}
