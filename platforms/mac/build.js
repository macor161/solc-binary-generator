const execa = require('execa')
const fs = require('fs-extra')
const path = require('path')
const HOMEBREW_PATH = '/usr/local/Cellar/solidity'


async function main() {
    try {
        const version = process.argv[2]
        const buildPath = path.join(__dirname, '..', '..', 'build', `mac-${version}`)
        const tmpPath = path.join(__dirname, '.tmp')
        const homebrewFile = path.join(tmpPath, 'solidity.rb')
        

        if (!version) {
            console.error('Specify a solc version to build')
            process.exit(1)
        }

        await uninstallSolidity()

        if (await fs.pathExists(buildPath)) 
            await fs.remove(buildPath)

        if (await fs.pathExists(tmpPath))
            await fs.remove(tmpPath)

        await fs.mkdirp(buildPath)
        await fs.mkdirp(tmpPath)
        
        await fs.copy(
            path.join(__dirname, 'versions', `solc-${version}.rb`), 
            homebrewFile
        )

        await execa('brew', ['install', 'solidity.rb'], { cwd: tmpPath })
            
        await fs.copy(
            path.join(HOMEBREW_PATH, version, 'bin', 'solc'), 
            path.join(buildPath, 'solc')
        )

        await fs.remove(tmpPath)
    } catch(err) {
        console.error('Error: ', err)
    }

}

async function uninstallSolidity() {
    try {
        await execa('brew', ['unlink', 'solidity'])
        await execa('brew', ['uninstall', 'solidity'])
    } catch(e) {
        // TODO: Validate error
    }
}

main()
