<!-- This README was generated with docout (https://github.com/tfwright/docout). Edits should be made to the formatter instead of this file, other changes will be overridden on compile. -->

# LiveAdmin

[![hex package](https://img.shields.io/hexpm/v/live_admin.svg)](https://hex.pm/packages/live_admin)
[![CI status](https://github.com/tfwright/live_admin/workflows/CI/badge.svg)](https://github.com/tfwright/live_admin/actions)

An admin UI for Phoenix applications built on [Phoenix LiveView](https://github.com/phoenixframework/phoenix_live_view) and [Ecto](https://github.com/elixir-ecto/ecto/).

Significant features:

* First class support for multi tenant applications via Ecto's `prefix` option
* Overridable views and API
* Easily add custom actions at the schema and record level
* Ability to edit (nested) embedded schemas

## Installation

First, ensure your Phoenix app has been configured to use [LiveView](https://hexdocs.pm/phoenix_live_view/installation.html).

Add to your app's `deps`:

```
{:live_admin, "~> 0.8.0"}
```

Add the following to your Phoenix router in any scope ready to serve a live route:

```
import LiveAdmin.Router
# ...
live_admin "/admin", ecto_repo: MyApp.Repo, resources: [MyApp.SomeEctoSchema]
```

See below as well as `LiveAdmin.Router.live_admin/2` for full list of options.

To customize a resource, pass a two element tuple when the schema module as the first element, and a keyword list of options is the second: `{MyApp.SomeEctoSchema, opts}`

Resource specific options:

* `title_with` - a binary, or MFA that returns a binary, used to identify the resource
* `label_with` - a binary, or MFA that returns a binary, used to identify individual records
* `list_with` - an atom or MFA that identifies the function that implements listing a resource
* `create_with` - an atom or MFA that identifies the function that implements creating a resource
* `update_with` - an atom or MFA that identifies the function that implements updating a record
* `delete_with` - an atom or MFA that identifies the function that implements deleting a record
* `validate_with` - an atom or MFA that identifies the function that implements validating a changed record
* `render_with` - an atom or MFA that identifies the function that implements table field rendering logic
* `hidden_fields` - a list of fields that should not be displayed in the UI
* `immutable_fields` - a list of fields that should not be editable in forms
* `actions` - list of atoms or MFAs that identify a function that operates on a record
* `tasks` - list atoms or MFAs that identify a function that operates on a resource
* `components` - keyword list of component module overrides for specific views (`:list`, `:new`, `:edit`, `:home`, `:nav`, `:session`)
* `slug_with` - a binary, atom, or MFA that returns a binary, used to generate url for resource

## App config

The following runtime config is supported:

* `ecto_repo` - the Ecto repo to use for db operations
* `prefix_options` - a list or MFA specifying `prefix` options to be passed to Ecto functions
* `css_overrides` - a binary or MFA that returns CSS to be appended to app css
* `session_store` - a module implementing the [LiveAdmin.Session.Store](/lib/live_admin/session/store.ex) behavior, used to persist session data

In addition to these, most resource configuration can be set at the top level in order to set a global default to apply to all resources unless overridden in their individual config.

Example:

```
config :live_admin,
  ecto_repo: MyApp.Repo,
  prefix_options: {MyApp.Accounts, :list_tenant_prefixes, []},
  immutable_fields: [:id, :inserted_at, :updated_at],
  label_with: :name
```

Or directly in the router:
```
live_admin "/admin", 
  resources: [MyApp.SomeEctoSchema],
  ecto_repo: MyApp.Repo, 
  prefix_options: {MyApp.Accounts, :list_tenant_prefixes, []},
  immutable_fields: [:id, :inserted_at, :updated_at],
  label_with: :name
```

See [development app](/dev.exs) for more example configuration.

---

README generated with [docout](https://github.com/tfwright/docout)
