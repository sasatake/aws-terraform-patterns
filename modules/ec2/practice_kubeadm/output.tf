output "master_id" {
  value = aws_spot_instance_request.master.spot_instance_id
}

output "worker_id" {
  value = aws_spot_instance_request.worker.spot_instance_id
}

output "master_private_key" {
  value = tls_private_key.master.private_key_pem
}

output "worker_private_key" {
  value = tls_private_key.worker.private_key_pem
}
