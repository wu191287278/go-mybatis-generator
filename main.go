package main

import (
	"database/sql"
	"encoding/json"
	"flag"
	_ "github.com/go-sql-driver/mysql"
	"log"
	"net/http"
	"os"
	"regexp"
	"strconv"
)

func main() {
	localhost := flag.String("host", "localhost", "mysql host")
	port := flag.Int("port", 3306, "mysql port")
	username := flag.String("username", "root", "username")
	password := flag.String("password", "root", "password")
	dbName := flag.String("dbname", "users", "db name")
	dir := flag.String("serve", "./", "static server directory")
    flag.Parse()
	dataSourceName := *username + ":" + *password + "@(" + *localhost + ":" + strconv.Itoa(*port) + ")/information_schema"
	log.Println("connect " + dataSourceName)
	db, _ := sql.Open("mysql", dataSourceName)
	defer db.Close()
	querySql := "select table_name,column_name,column_key,data_type,column_comment,extra from columns where table_schema = ?"
	stat, e := db.Prepare(querySql)
	if e != nil {
		panic(e)
	}
	rows, e := stat.Query(dbName)
	if e != nil {
		panic(e)
	}
	m := make(map[string]*Table)
	tables := make([]*Table, 0)

	for rows.Next() {
		var tableName string
		var columnName string
		var columnKey string
		var extra string
		var dataType string
		var comment string
		e := rows.Scan(&tableName, &columnName, &columnKey, &dataType, &comment, &extra)
		if e != nil {
			panic(e)
		}
		table, ok := m[tableName];
		if !ok {
			t := Table{TableName: tableName, Fields: make([]Field, 0), PrimaryKeys: make([]Field, 0)}
			table = &t
			m[tableName] = table
			tables = append(tables, table)
		}
		r, _ := regexp.Compile("[*|/|\t|\\n|\\r|\\r]")
		comment = r.ReplaceAllString(comment, "")
		field := Field{Name: columnName, Type: dataType, Remarks: comment}
		table.Fields = append(table.Fields, field)
		if columnKey == "PRI" {
			table.PrimaryKeys = append(table.PrimaryKeys, field)
		}
		if extra == "auto_increment" {
			table.IsAutoIncrement = true
		}
	}

	example := Example{Tables: tables}
	bytes, e := json.MarshalIndent(example, "", "  ")
	if e != nil {
		panic(e)
	}
	filename := *dir + "/template/example.json"
	log.Println("Write to "+filename)
	file, e := os.Create(filename)
	if e != nil {
		panic(e)
	}
	if e != nil {
		panic(e)
	}
	file.Write(bytes)
    file.Close()
    log.Println("Serving files from "+*dir+" at http://localhost:8080\n"+"Press Ctrl+C to quit")
	log.Fatal(http.ListenAndServe(":8080", http.FileServer(http.Dir(*dir))))
}

type Example struct {
	Tables []*Table `json:"tables"`
}

type Table struct {
	TableName       string  `json:"tableName"`
	IsAutoIncrement bool    `json:"isAutoIncrement"`
	Fields          []Field `json:"fields"`
	PrimaryKeys     []Field `json:"primaryKeys"`
}

type Field struct {
	Name    string `json:"name"`
	Type    string `json:"type"`
	Remarks string `json:"remarks",omitempty`
}
