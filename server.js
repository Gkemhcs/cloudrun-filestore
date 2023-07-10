const express=require("express")
const app=express()
const fs=require("fs")
const bodyParser=require("body-parser")
app.set("view engine","ejs")
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended:true}))
app.get("/",(req,res)=>{
    res.render("home")
})
app.post("/save",(req,res)=>{
    const {filename,content}=req.body
    console.log(req.body) 
    fs.writeFile(`/mnt/nfs/${filename}.txt`,content,(err)=>{
        if(err) throw err 
        else{
           res.send("ok")
        }
    })
})
app.listen(8080,()=>{
    console.log("server started")
})