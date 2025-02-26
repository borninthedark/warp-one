terraform {
  backend "remote" {
    hostname     = "app.terraform.io"  # Terraform Cloud hostname
    organization = "Defiant-Emissary"  # TFC organization

    workspaces {
      name = "warp-one"  # Unique workspace per environment
    }
  }
}
