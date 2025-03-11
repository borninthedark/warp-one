terraform {
  backend "remote" {
    organization = "DefiantEmissary"

    workspaces {
      name = "warp-one"
    }
  }
}
