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
# https://github.com/ethereum/homebrew-ethereum/blob/b346d963ce383bbeaf2f4047c65edea0ac860fbf/solidity.rb
#------------------------------------------------------------------------------

class Solidity < Formula
    desc "The Solidity Contract-Oriented Programming Language"
    homepage "http://solidity.readthedocs.org"
    url "https://github.com/ethereum/solidity/releases/download/v0.5.7/solidity_0.5.7.tar.gz"
    version "0.5.7"
    sha256 "d16584efde259faff6b1552688b163fedeabe53376b77540560dc3a139f4b81d"
  
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