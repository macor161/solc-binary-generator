#------------------------------------------------------------------------------
# solidity.rb
#
# Homebrew formula for solidity.  Homebrew (http://brew.sh/) is
# the de-facto standard package manager for OS X, and this Ruby script
# contains the metadata used to map command-line user settings used
# with the 'brew' command onto build options.
#
# Our documentation for the solidity Homebrew setup is at:
#
# http://solidity.readthedocs.io/en/latest/installing-solidity.html
#
# (c) 2014-2017 solidity contributors.
# https://github.com/ethereum/homebrew-ethereum/blob/459aa28331a4cd64f26b0872a5f3688223cebf23/solidity.rb
#------------------------------------------------------------------------------

class Solidity < Formula
    desc "The Solidity Contract-Oriented Programming Language"
    homepage "http://solidity.readthedocs.org"
    url "https://github.com/ethereum/solidity/releases/download/v0.5.0/solidity_0.5.0.tar.gz"
    version "0.5.0"
    sha256 "0620b90a008dcf76863a2c817b3870237f340d6fd4c861940340ae9ccc62d47d"
  
    depends_on "cmake" => :build
    depends_on "boost" => "c++11"
    # Note: due to a homebrew limitation, ccache will always be detected and cannot be turned off.
    depends_on "ccache" => :build
  
    def install
      system "cmake", ".", *std_cmake_args, "-DTESTS=OFF"
      system "make", "install"
    end
  
    test do
      system "#{bin}/solc", "--version"
    end
  end