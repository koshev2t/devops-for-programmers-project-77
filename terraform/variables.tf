variable "yc_iam_token" {
  description = "IAM-токен (время жизни не более 12 часов)"
  type        = string
  sensitive   = true
}

variable "yc_token" {
  description = "OAuth-токен"
  type        = string
  sensitive   = true
}

variable "yc_cloud_id" {
  description = "id облака"
  type        = string
  sensitive   = true
}

variable "yc_folder_id" {
  description = "id каталога"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Имя БД"
  type        = string
  sensitive   = true
}

variable "db_user" {
  description = "Пользователь"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Пароль"
  type        = string
  sensitive   = true
}

variable "yc_postgresql_version" {
  description = "Версия PostgreSQL для использования в кластере Yandex Managed DB"
  type        = string
  default     = "13"  
}