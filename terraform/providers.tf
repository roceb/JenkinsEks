provider "aws" {
  region = "us-east-2"
  #   I normally set my profile as prod by default. In theory you can remove this, and use the export AWS_PROFILE to control which profile to use
  # Useful for when you have an internal jenkins and one that has internet access. 
  profile = "prod"
}
