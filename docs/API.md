# 管理端

#### 1、登录

管理员使用该接口进行登录。前端发送的登录请求中包含用户名、密码。 后端接收后，对账号密码的正确性进行校验。 如果校验通过，服务端在响应消息头使用set_cookie 存入sessionid。

##### 请求

**请求头**

```
POST /api/admin/login
Content-Type: application/json
```

**消息体**

```
{
  "name" : "张三",
  "pwd" : "123456"
}
```

**参数信息**

| 参数名 | 示例   | 必要性 | 含义               | 类型   |
| ------ | ------ | ------ | ------------------ | ------ |
| name   | 张三   | 必有   | 管理员登录的用户名 | string |
| pwd    | 123456 | 必有   | 管理员登录的密码   | string |

##### 响应

**响应头**

```
200 OK
Content-Type: application/json
set_cookie: sessionid=<sessionid数值>
```

**消息体**

正常返回(info==='Ok'):

```
{
  "info": 'Ok'
}
```

异常返回(info==='Error'):

```
{
"info":'Error'
}
```

**参数信息**

| 参数名 | 示例 | 必要性 | 含义         | 类型   |
| ------ | ---- | ------ | ------------ | :----- |
| info   | Ok   | 必有   | 是否正常返回 | string |



#### 2、登出

##### 请求

**请求头**

```
DELETE /api/admin/logout
Cookie: sessionid=<sessionid数值>
```

##### 响应

后端清除对应session，然后返回响应消息。

**响应头**

```
200 OK
Content-Type: application/json
Set-Cookie: sessionid=""
```

**消息体**

正常返回(info ===Ok):

```
{
  "info":'OK'
}
```

**参数信息**

| 参数名 | 示例 | 必要性 | 含义         | 类型   |
| ------ | ---- | ------ | ------------ | ------ |
| info   | OK   | 必有   | 是否正常返回 | string |



#### 3、查看用户信息

管理员查看用户信息。

##### 请求

**请求头**

```
GET /api/admin/manage_user
Cookie: sessionid=<sessionid数值>
```

##### 响应

**响应头**

```
200 OK
Content-Type: application/json
```

**消息体**

正常返回(info===Ok):

```
{
  "info": 'Ok',
  "list": { 
    "name": "小赵",
    "numm":"888",
    "numc":"777",
    "numr":"666"
  }
}
```

**参数信息**

| 参数名 | 示例    | 必要性 | 含义         | 类型info   |
| ------ | ------- | ------ | ------------ | ---------- |
| info   | OK      | 必有   | 是否正常返回 | string     |
| list   | [{},{}] | 必有   | 用户信息     | dictionary |

其中`list`中的参数信息如下所示：

| 参数名 | 示例 | 必要性 | 含义     | 类型   |
| ------ | ---- | ------ | -------- | ------ |
| name   | 小赵 | 必有   | 用户名   | string |
| numm   | 888  | 必有   | 单选数量 | string |
| numc   | 777  | 必有   | 完型数量 | string |
| numr   | 666  | 必有   | 阅读数量 | string |



#### 4、管理员删除用户

管理员删除用户

##### 请求

**请求头**

```
 DELETE /api/admin/manage_user
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```



#### 5、管理员查看题目

##### 请求

**请求头**

```
 GET /api/admin/question
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```



#### 6、管理员上传题目

管理员上传题目

##### 请求

**请求头**

```
 POST /api/admin/question
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```



#### 7、管理员修改题目

##### 请求

**请求头**

```
 PUT /api/admin/question
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```



#### 8、管理员删除题目

##### 请求

**请求头**

```
 DELETE /api/admin/question
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```



#### 9、管理员查看题解

##### 请求

**请求头**

```
 GET /api/admin/que_solution
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```



#### 10、管理员删除题解

##### 请求

**请求头**

```
 DELETE /api/admin/que_solution
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```



#### 11、管理员查看公告

##### 请求

**请求头**

```
 GET /api/admin/notice
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```



#### 12、管理员创建公告

##### 请求

**请求头**

```
 POST /api/admin/notice
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```



#### 13、管理员修改公告

##### 请求

**请求头**

```
 PUT /api/admin/notice
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```



#### 14、管理员删除公告

##### 请求

**请求头**

```
 DELETE /api/admin/notice
 Cookie: sessionid=<sessionid数值>
```

**响应头**

```
200 OK
Content-Type: application/json
```

