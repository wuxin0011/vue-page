// const path = require('node:path')
// const fs = require('node:fs')

// const folder = path.resolve(__dirname, '../components')
// const sufuix = /\.vue$/ig


// function readFile(){
//     return fs.readdirSync(folder).filter(componet=>sufuix.test(componet)).map(component=>component.replace(sufuix,''))
// }

// const findComponents = readFile()
// console.log('本次扫描组件有',findComponents)

const findComponents = ['Card','Fantasy','GlobalTip','IndexBigImg','MyPlayer']
console.log('本次扫描组件有',findComponents)

export default findComponents;