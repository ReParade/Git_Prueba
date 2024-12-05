# C# Coding Style

## General Coding Style

The general rule we follow is "use Visual Studio defaults."

### Braces and Indentation

1. We use [Allman style](http://en.wikipedia.org/wiki/Indent_style#Allman_style) braces, where each brace begins on a new line.
   - A single-line statement block can go without braces, but the block must be properly indented on its own line and must not be nested in other statement blocks that use braces.
   - One exception is that a `using` statement is permitted to be nested within another `using` statement by starting on the following line at the same indentation level, even if the nested `using` contains a controlled block.
2. We use four spaces of indentation (no tabs).

### Fields and Variables

3. Use `_camelCase` for internal and private fields and `readonly` where possible.
   - Prefix internal and private instance fields with `_`, static fields with `s_`, and thread static fields with `t_`.
   - Public fields should use PascalCasing with no prefix and should be used sparingly.
4. Avoid `this.` unless absolutely necessary.
5. Always specify the visibility, even if it's the default (e.g., `private string _foo` not `string _foo`). Visibility should be the first modifier (e.g., `public abstract` not `abstract public`).

### Namespaces and Imports

6. Namespace imports should be specified at the top of the file, *outside* of `namespace` declarations, and should be sorted alphabetically, with the exception of `System.*` namespaces, which are to be placed on top of all others.

### Formatting

7. Avoid more than one empty line at any time. For example, do not have two blank lines between members of a type.
8. Avoid spurious free spaces (e.g., avoid `if (someVar == 0) ...` where the dots mark the spurious free spaces).
9. If a file happens to differ in style from these guidelines (e.g., private members are named `m_member` rather than `_member`), the existing style in that file takes precedence.

### Type Usage

10. Use `var` only when the type is explicitly named on the right-hand side, typically due to `new` or an explicit cast (e.g., `var stream = new FileStream(...)`).
    - Similarly, target-typed `new()` can only be used when the type is explicitly named on the left-hand side in a variable definition or field definition statement (e.g., `FileStream stream = new(...);`).
11. Use language keywords instead of BCL types (e.g., `int`, `string`, `float` instead of `Int32`, `String`, `Single`).

### Naming Conventions

12. Use PascalCasing to name all constant local variables and fields. The only exception is for interop code where the constant value should exactly match the name and value of the code you are calling via interop.
13. Use PascalCasing for all method names, including local functions.
14. Use `nameof(...)` instead of `"..."` whenever possible and relevant.
15. Fields should be specified at the top within type declarations.

### Special Cases

16. When including non-ASCII characters in the source code, use Unicode escape sequences (`\uXXXX`) instead of literal characters.
17. When using labels (for `goto`), indent the label one less than the current indentation.
18. When using a single-statement `if`, follow these conventions:
    - Never use single-line form (e.g., `if (source == null) throw new ArgumentNullException("source");`).
    - Braces are required if any block of an `if`/`else if`/.../`else` compound statement uses braces.
    - Braces may be omitted only if the body of *every* block associated with the `if`/`else if`/.../`else` compound statement is placed on a single line.
19. Make all internal and private types `static` or `sealed` unless derivation from them is required.

### Naming Rules

20. Names of classes, methods, enumerations, public fields, public properties, and namespaces should use PascalCase.
21. Names of local variables and parameters should use camelCase.
22. Names of interfaces should start with `I`, e.g., `IInterface`.

### Conditional Statements

- Simplify if conditions
   - Avoid overly complex conditions in if statements.
   - If an if condition contains more than two logical operators (&& or ||), break the condition into variables or helper methods to improve readability.
   - Use descriptive names for the variables or methods to clarify the intent of the condition.

   ```csharp
   if (user.IsActive && user.Role == "Admin" && DateTime.Now > user.LastLogin.AddDays(30))
   {
      // Logic
   }

   // Alternatively, encapsulate the logic in a method:
   if (IsAdminWithExpiredLogin(user))
   {
      // Logic
   }

   private bool IsAdminWithExpiredLogin(User user)
   {
      return user.IsActive && user.Role == "Admin" && DateTime.Now > user.LastLogin.AddDays(30);
   }
   ```

## Controller Conventions for CRUD Operations

### General Guidelines

- Follow RESTful conventions for naming and HTTP methods.
- Use descriptive names for actions that align with their purpose and HTTP method.

### Naming Actions

1. **[HttpGet]** (Retrieve a list): Name the action `Index`.
   ```csharp
   [HttpGet]
   public ActionResult Index()
   {
       // Logic to return a list of resources
   }
   ```

2. **[HttpGet("{id}")]** (Retrieve a single item by ID): Name the action `Show`.
   ```csharp
   [HttpGet("{id}")]
   public ActionResult Show(int id)
   {
       // Logic to return a single resource
   }
   ```

3. **[HttpPost]** (Create a new resource): Name the action `Create`.
   ```csharp
   [HttpPost]
   public ActionResult Create([FromBody] ResourceDto resource)
   {
       // Logic to create a new resource
   }
   ```

4. **[HttpPut("{id}")]** (Update an existing resource): Name the action `Update`.
   ```csharp
   [HttpPut("{id}")]
   public ActionResult Update(int id, [FromBody] ResourceDto resource)
   {
       // Logic to update the resource
   }
   ```

5. **[HttpDelete("{id}")]** (Delete a resource): Name the action `Delete`.
   ```csharp
   [HttpDelete("{id}")]
   public ActionResult Delete(int id)
   {
      // Logic to delete the resource
   }
   ```