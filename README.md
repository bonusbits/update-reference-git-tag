# Update Reference Git Tag
Simple Script to Update Reference Git Tag. Such as, "latest" or "dev". 
Basically this can be used for moving a reference version tag such as latest.
So we can set a tag such as **latest** to a specific commit version. 
Currently it is wrote to set an alternative or reference tag to another tags commit version. 
So if there is a release tag of 1.0.0, we can create another tag named **latest** that is the samve version as 1.0.0.
 Then we can when 1.0.1 is released we can use the script again to move the **latest** tag to 1.0.1 etc. 
 Of course we can then add this to your CI.
 
Basically the script removes that reference script and re-creates it at a new commit version.

# Usage
```bash
urgt.sh -r [release_tag_name] -n [new_tag_name]
   
Options:
   -r Release Tag Name               :  (Required) i.e. v1.0.0
   -n New Tag Name to add/replace    :  (Optional) i.e. latest, rc, dev, or beta. (Defaults to 'latest')
```

### Symlink
After cloning the repo local you optionally can make a symbolic link to the shell script so it's easily accessible as follows.

```bash
 if [ ! -h "/usr/local/bin/urgt" ]; then
   ln -s "/path/to/clone/update_reference_git_tag/urgt.sh" /usr/local/bin/urgt
 fi
```

# Example
1. Set release *latest* tag to *1.0.0* release
    * ```urgt -r 1.0.0 -n latest```
1. Set release *latest* tag to *1.1.0* release
    * ```urgt -r 1.1.0 -n latest```
