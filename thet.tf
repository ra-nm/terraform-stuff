variable "endpoints" {
  type = "list"
  default = [
    { endpoint1 = "https://endpoint-1.example.com" },
    { endpoint2 = "https://endpoint-2.example.com" },
    { endpoint3 = "https://endpoint-3.example.com" },
    { endpoint4 = "https://endpoint-4.example.com" }
  ]
}

data "template_file" "d_json" {
  template = "${file("${path.module}/d.json.tmpl")}"
  count = "${length(var.endpoints)}"
  vars {
    endpoint = "${element(values(var.endpoints[count.index]), 0)}"
    name = "${element(keys(var.endpoints[count.index]), 0)}"
  }
}

output "d.data" {
  value="${data.template_file.d_json.*.rendered}"
}
