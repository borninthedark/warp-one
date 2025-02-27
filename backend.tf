terraform {
  backend "remote" {
    organization = "Defiant-Emissary"  

    workspaces {
      name = "warp-one"  
    }
  }
}
