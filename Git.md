# Git submodules

Tuto-init is included in dbt-podman as a git submodule.
Tutorial (branch develop_pg) is included in dbt-podman as a git submodule.

Add a git submodule

```powershell
git submodule add -b develop_pg https://github.com/mgn-dbt/tutorial.git dbt/tutorial
```

Cloning a repository with submodules

```powershell
git clone --recurse-submodules https://github.com/mgn-dbt/dbt-podman.git
```

Update submodules in a repository

```powershell
git submodule update --remote --merge
```

Cf [git submodules](https://blog.stephane-robert.info/docs/developper/version/git/submodules/)
