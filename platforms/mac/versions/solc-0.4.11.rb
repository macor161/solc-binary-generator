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
#------------------------------------------------------------------------------

class Solidity < Formula
  desc "The Solidity Contract-Oriented Programming Language"
  homepage "http://solidity.readthedocs.org"
  url "https://github.com/ethereum/solidity/releases/download/v0.4.11/solidity_0.4.11.tar.gz"
  version "0.4.11"
  sha256 "5a96a3ba4d0d6457ad8101d6219152610e46b384bfbd48244e3474573f7a6d47"

  depends_on "cmake" => :build
  depends_on "boost@1.60" => "c++11"
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
