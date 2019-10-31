# go-mybatis-generator

## Introduction

该项目是 mybatis-generator go版本的移植,同时加入协程与分库分表支持

## 预览

![preview](./images/preview.jpg)


### Go Mybatis Generator

在线 [Go Mybatis Generator](https://wu191287278.github.io/go-mybatis-generator/index.html) 生成代码


#### 


#### 从数据库中生成元数据信息 并生成项目代码
```
git clone https://github.com/wu191287278/go-mybatis-generator
cd go-mybatis-generator
go get github.com/go-sql-driver/mysql
go build
./go-mybatis-generator -host localhost -username root -password root -dbname db #默认生成元数据到template/example.json文件中
```

#### Getting Started
```
cd 生成的项目
go list -m -u all
go mod vendor
go run main.go
```

#### SelectByExample
```go
package main

import (
	"database/sql"
	"fmt"
	. "mysql_demo/domain"
)

func main() {
	db, _ := sql.Open("mysql", "root:root@(localhost:3306)/users")
	defer db.Close()
	users, e := NewUsersExample().WithDB(db).WithPage(1, 20).AndUserIdEqualTo(1).AndEmailLike("%@qq.com").SelectByExample()
	if e != nil {
		panic(e)
	}
	fmt.Println(users)
}

```

#### ChannelByExample

```go
package main

import (
	"database/sql"
	"fmt"
	. "mysql_demo/domain"
)

func main() {
	db, _ := sql.Open("mysql", "root:root@(localhost:3306)/users")
	defer db.Close()
	ch := make(chan *Users, 1)
	go func(ch chan *Users) {
		for u := range ch {
			fmt.Println(u)
		}
	}(ch)
	e := NewUsersExample().WithDB(db).WithPage(1, 20).AndUserIdEqualTo(1).SelectChannel(ch)
	if e != nil {
		panic(e)
	}
}

```
