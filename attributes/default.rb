# Package
default['gitlab']['packages'] = %w{
  build-essential zlib1g-dev libyaml-dev libssl-dev libgdbm-dev libreadline-dev libncurses5-dev libffi-dev
  curl openssh-server checkinstall libxml2-dev libxslt-dev libcurl4-openssl-dev libicu-dev
}
default['gitlab']['ruby'] = "1.9.3-p392"

# User
default['gitlab']['user'] = "git"
default['gitlab']['group'] = "git"
default['gitlab']['home'] = "/home/git"

# GitLab shell
default['gitlab']['shell_repository'] = "git://github.com/gitlabhq/gitlab-shell.git"
default['gitlab']['shell_revision'] = "v1.5.0"
default['gitlab']['shell_path'] = "/home/git/gitlab-shell"

# GitLab hq
default['gitlab']['repository'] = "git://github.com/gitlabhq/gitlabhq.git"
default['gitlab']['revision'] = "v5.2.1"
default['gitlab']['path'] = "/home/git/gitlab"

# GitLab shell config
default['gitlab']['url'] = "http://localhost/"
default['gitlab']['repos_path'] = "/home/git/repositories"
default['gitlab']['redis_path'] = "/usr/local/bin/redis-cli"
default['gitlab']['redis_host'] = "127.0.0.1"
default['gitlab']['redis_port'] = "6379"
default['gitlab']['namespace']  = "resque:gitlab"

# GitLab hq config
default['gitlab']['satellites_path'] = "/home/git/gitlab-satellites"
default['gitlab']['git_path'] = "/usr/local/bin/git"
default['gitlab']['host'] = "localhost"
default['gitlab']['port'] = "80"
default['gitlab']['email_from'] = "gitlab@localhost"
default['gitlab']['support_email'] = "support@localhost"


# Gems
default['gitlab']['bundle_install'] = "bundle install --path=.bundle --deployment --without development test mysql"
