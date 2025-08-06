# Git Workflow - Proyecto FitConnet

## 🔀 Flujo de ramas

- **main**: Rama principal. Solo se hace merge desde `develop` después de pruebas.
- **develop**: Rama de integración. Se hacen merges desde `feature/*`.
- **feature/***: Ramas por funcionalidad específica. Se crean desde `develop`.

Ejemplos:
- `feature/api-rutinas`
- `feature/ui-dashboard`
- `feature/auth-usuarios`

---

## ✅ Convención de commits

Usamos una convención basada en tipo + descripción corta:

- `feat`: nueva funcionalidad
- `fix`: corrección de errores
- `docs`: cambios en documentación
- `style`: formateo, indentación (sin cambios funcionales)
- `refactor`: refactorización de código
- `test`: pruebas
- `chore`: tareas menores, configuración

**Ejemplos:**

```bash
git commit -m "feat: agregar endpoint para registrar usuarios"
git commit -m "fix: corregir error en login"
git commit -m "docs: actualizar README con pasos de instalación"

