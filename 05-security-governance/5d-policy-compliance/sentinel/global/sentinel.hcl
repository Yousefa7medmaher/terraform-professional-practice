policy "require-private-modules" {
  source            = "./require-private-modules.sentinel"
  enforcement_level = "hard-mandatory"
}

policy "require-tags" {
  source            = "./require-tags.sentinel"
  enforcement_level = "advisory"
}
