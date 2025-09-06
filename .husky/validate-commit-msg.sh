#!/bin/sh

# Obtener el mensaje del commit
commit_msg=$(cat "$1")

echo "🔍 Validating commit message..."
echo ""

# Validar el formato del mensaje
if ! echo "$commit_msg" | grep -qE '^(feat|fix|docs|style|refactor|perf|test|chore|build|ci|revert|merge|config)(\([a-z0-9-]+\))?: [a-z].*'; then
    echo "❌ Error: The commit message does not follow the correct format."
    echo "The format must be: <type>(<scope>): <subject>"
    echo "Allowed types: feat, fix, docs, style, refactor, perf, test, chore, build, ci, revert, merge, config"
    echo "Example: feat(HU123): implements new functionality"
    echo "Example: fix(api): fix wrong calculation of request body checksum"
    echo "Example: chore: initial commit"
    echo "Example: refactor: implement fibonacci number calculation as recursion"
    echo ""
    exit 1
fi

# Validar que todo esté en minúsculas
if echo "$commit_msg" | grep -q '[A-Z]'; then
    echo "❌ Error: The commit message must be in lowercase."
    echo ""
    exit 1
fi

# Validar que el subject no exceda los 72 caracteres
subject=$(echo "$commit_msg" | head -n1 | cut -d':' -f2- | sed 's/^ *//')
if [ ${#subject} -gt 72 ]; then
    echo "❌ Error: The subject of the commit must not exceed 72 characters."
    echo ""
    exit 1
fi

# Validar que haya una línea en blanco después del subject
if ! echo "$commit_msg" | head -n2 | tail -n1 | grep -q '^$'; then
    echo "❌ Error: There must be a blank line between the subject and the body."
    echo ""
   exit 1
fi

# Validar que el body no esté vacío
body=$(echo "$commit_msg" | tail -n +3)
if [ -z "$body" ]; then
    echo "❌ Error: The commit body cannot be empty."
    echo ""
    exit 1
fi

  # Validar palabras comunes en español que no deberían aparecer
  spanish_words="(actualiza|actualizado|actualizando|actualización|actualizar|ajusta|ajustado|ajustando|ajuste|ajustes|ajustar|algoritmo|algoritmos|añade|añadido|añadiendo|añadir|aprobación|aprobado|aprobados|aprobando|arreglo|arreglado|arreglar|atributo|atributos|autenticación|autorización|base de datos|bucle|caché|cabecera|cabeceras|cambia|cambiado|cambiando|cambiar|cambio|clase|clases|columna|columnas|comentario|comentarios|compila|compilación|compilar|componente|componentes|condición|condiciones|configura|configurado|configurando|configuración|configurar|construcción|construir|construye|construyendo|consulta|consultas|constante|constantes|controlador|controladores|corregido|corregir|corrección|corrigiendo|corrige|crea|creación|creado|creando|crear|cuerpo|dato|datos|dependencia|dependencias|depura|depurado|depurando|depuración|depurar|desarrollo|deshacer|deshecho|desplegado|desplegar|despliega|despliegue|directorio|documenta|documentación|documentado|documentando|documentar|elemento|elementos|elimina|eliminación|eliminado|eliminando|eliminar|entorno|entornos|estructura|estructuras|estilo|excepción|excepciones|expresión|expresiones|flujo|flujos|formato|formulario|formularios|función|funciones|gestión|implementa|implementación|implementado|implementando|implementar|índice|índices|inicial|inicio|iniciado|instancia|instancias|integración|integrado|integrando|integrar|interfaz|interfaces|iteración|iteraciones|legado|librería|librerías|limpieza|limpiado|limpiando|limpiar|lista|listas|lógica|matriz|matrices|mejora|mejorado|mejorando|mejorar|método|métodos|migración|migraciones|migrado|migrando|migrar|modelo|modelos|modifica|modificación|modificado|modificando|modificar|módulo|módulos|nueva|nuevas|nuevo|nuevos|número|números|objeto|objetos|obsoleto|obsoletos|optimiza|optimizado|optimización|optimizar|paquete|paquetes|parámetro|parámetros|permiso|permisos|petición|peticiones|plantilla|plantillas|procedimiento|procedimientos|propiedad|propiedades|prueba|pruebas|quitar|quitado|quitando|registro|registros|rendimiento|repetición|repeticiones|resolviendo|resuelto|respuesta|respuestas|retorno|revertido|revertir|revirtiendo|revierte|ruta|rutas|seguridad|sentencia|sentencias|servicio|servicios|soluciona|solucionado|solucionando|solucionar|tabla|tablas|tipo|tipos|usuario|usuarios|utilidad|utilidades|validación|validaciones|validar|variable|variables|vista|vistas)"
  if echo "$commit_msg" | grep -qiE "$spanish_words"; then
      echo "❌ Error: The commit message appears to contain Spanish words. Please use English."
      echo ""
      exit 1
  fi

echo "✅ Commit message is valid"
echo ""
exit 0 