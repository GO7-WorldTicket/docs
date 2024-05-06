
# Local Testing for GitHub Pages with Jekyll

This guide outlines the steps to install and test GitHub Pages locally using Jekyll on a Mac. It is designed to help you preview your site before pushing changes to your GitHub repository.

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Install Ruby](#install-ruby)
3. [Install Jekyll and Bundler](#install-jekyll-and-bundler)
4. [Set Up Local Repository](#set-up-local-repository)
5. [Run Jekyll Locally](#run-jekyll-locally)

## Prerequisites

### Install Homebrew
Homebrew is a package manager for macOS, used here to install Ruby and other dependencies:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Install Ruby
Install a version of Ruby via Homebrew to avoid conflicts with the system-installed Ruby:
```bash
brew install ruby
```
Add Ruby to your PATH by including the following in your `.zshrc`:
```bash
echo 'export PATH="/opt/homebrew/opt/ruby/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

## Install Jekyll and Bundler

### Install Gems
Install Jekyll and Bundler, which are required to emulate the GitHub Pages environment:
```bash
gem install --user-install bundler jekyll
```

## Set Up Local Repository

### Clone Your Repository
Clone your GitHub Pages repository and navigate into it:
```bash
git clone https://github.com/GO7-WorldTicket/docs.git
cd docs
```

### Set Up Gemfile
Ensure the `Gemfile` and `_config.yml` are in the root directory. If they are not, copy them:
```bash
cp Gemfile ../
cp _config.yml ../
```

### Install Dependencies
Navigate to the root directory and install the dependencies specified in your Gemfile using Bundler:
```bash
cd ..
bundle install
```

## Run Jekyll Locally

### Start Jekyll Server
Start the local Jekyll server using Bundler to ensure the environment matches GitHub Pages:
```bash
bundle exec jekyll serve
```

### Access Your Site
View your local site by navigating to `http://127.0.0.1:4000/docs/ota/OTA_API_SAR.html` in your web browser.

By following these steps, you can preview changes to your GitHub Pages site locally, ensuring everything is as expected before updating the live site.
