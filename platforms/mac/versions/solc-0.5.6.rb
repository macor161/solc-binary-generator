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
# https://github.com/ethereum/homebrew-ethereum/blob/1ecf6c60875740133ee51f6167aef9a4f05986e7/solidity.rb
#------------------------------------------------------------------------------

class Solidity < Formula
    desc "The Solidity Contract-Oriented Programming Language"
    homepage "http://solidity.readthedocs.org"
    url "https://github.com/ethereum/solidity/releases/download/v0.5.6/solidity_0.5.6.tar.gz"
    version "0.5.6"
    sha256 "88fd1d64e24148fec64a80bff2c73a5588172558867455f7922669f5ea8e33b8"
  
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