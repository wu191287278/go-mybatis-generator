# go-mybatis-generator

## Introduction

该项目是 mybatis-generator go版本的移植,

## 预览

![preview](./images/preivew.jpg)


### ElasticSearch Query

前往 [ElasticSearch Query](https://wu191287278.github.io/generator/elasticsearch/java/index.html) 生成代码




#### Getting Started

```sql
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=994 DEFAULT CHARSET=utf8mb4;
```

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
	users, e := NewUsersExample().WithDB(db).WithPage(1, 20).AndUserIdEqualTo(1).AndEmailLike("name%").SelectByExample()
	if e != nil {
		panic(e)
	}
	fmt.Println(users)
}

```

#### 从数据库元数据中生成mapping信息

[MappingUtils.java](./elasticsearch/java/template/MappingUtils.java)

