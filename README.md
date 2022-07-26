# senior_media

## Project setup
```
//Install Bundler gem
gem install bundler

//Run
bundle install
```

## add config/master.key 

```
2bef56128c83c67bb0623d9cea97ede7
```

### install DB
```
rails db:migrate
```

## if you need to modify JWT secret key

```
// if you need to define your editor in windows
// $env:EDITOR="code --wait"

rails credentials:edit
```


### Compiles and hot-reloads for development
```
rails server
```

