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

echo "✅ Commit message is valid"
echo ""
exit 0 