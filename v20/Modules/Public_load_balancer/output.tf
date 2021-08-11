/* output "lb_rules" {
  description = "Map output of the Load Balancers Rules"
  value       = { for k, b in azurerm_lb_rule.lb_rule_https : k => b }
} */