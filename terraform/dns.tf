resource "yandex_dns_zone" "dns_zone" {
  name = "example-zone"
  zone = "nutakoe.ru."
}

resource "yandex_dns_recordset" "a_record" {
  zone_id = yandex_dns_zone.dns_zone.id
  name    = "nutakoe.ru."
  type    = "A"
  ttl     = 300
  data    = [yandex_alb_load_balancer.project-balancer.listener[0].endpoint[0].address[0].external_ipv4_address[0].address]
}