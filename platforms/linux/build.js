const execa = require('execa')
const fs = require('fs-extra')
const git = require('simple-git/promise')
const path = require('path')

const SOLC_REPO = 'https://github.com/ethereum/solidity.git'


async function main() {
    const version = process.argv[2]
    const buildPath = path.join(__dirname, '..', '..', 'build', `linux-${version}`)
    const tmpPath = path.join(__dirname, '.tmp')
        

    if (!version) {
        console.error('Specify a solc version to build')
        process.exit(1)
    }

    if (await fs.pathExists(buildPath)) 
        await fs.remove(buildPath)

    if (await fs.pathExists(tmpPath))
        await fs.remove(tmpPath)

    await fs.mkdirp(buildPath)
    await fs.mkdirp(tmpPath)

    await git(tmpPath).clone(SOLC_REPO)
    const repo = git(path.join(tmpPath, 'solidity'))
    await repo.checkout(`tags/v${version}`)

    await fs.mkdirp(path.join(tmpPath, 'solidity', 'build'))

    await execa('cmake', ['..'], { cwd: path.join(tmpPath, 'solidity', 'build') })
    await execa('make', [], { cwd: path.join(tmpPath, 'solidity', 'build') })

    //await fs.remove(tmpPath)
    
}


main()