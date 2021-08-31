# terraform-aws-modules

## Meta-arguments

 - source  = Es un argumento obligatorio para todos los modulos y sirve para referenciar la ubicacion del mismo
 - version = Es un argumento recomendado para los modulos publicados en Terraform Registry
 - depends_on = Este argumento crea dependecia explicita entre recursos para evitar futuros conflictos
 - count, for_each = Crea multiples instancias de un modulo a partir de un bloque de modulo definido
 - element(list, index) = Recupera un solo elemento de una lista
 - merge()  = Acepta un número arbitrario de mapas u objetos y devuelve un único mapa u objeto que contiene un conjunto combinado de elementos de todos los argumentos
 - lookup(map, key, default) = Recupera el valor de un solo elemento de un mapa, dada su clave. Si la clave dada no existe, se devuelve el valor predeterminado dado.

## Block

### dynamic (supported inside resource, data, provider, and provisioner blocks):

 * Un bloque dinámico actúa como una expresión for, pero produce bloques anidados en lugar de un valor tecleado complejo. Se itera sobre un valor complejo dado y genera un bloque anidado para cada elemento de ese valor complejo.
 * El bloque content anidado define el cuerpo de cada bloque generado. Puede usar la variable de iterador temporal dentro de este bloque.

```
resource "aws_elastic_beanstalk_environment" "tfenvtest" {
  name                = "tf-test-name"
  application         = "${aws_elastic_beanstalk_application.tftest.name}"
  solution_stack_name = "64bit Amazon Linux 2018.03 v2.11.4 running Go 1.12.6"

  dynamic "setting" {
    for_each = var.settings
    content {
      namespace = setting.value["namespace"]
      name = setting.value["name"]
      value = setting.value["value"]
    }
  }
}
```
