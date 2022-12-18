import unittest
import os

class TestCertificateGeneration(unittest.TestCase):
  def test_certificate_generation(self):
    # Check if the private key and CSR files were created
    self.assertTrue(os.path.exists('/etc/ssl/private/example.key'))
    self.assertTrue(os.path.exists('/etc/ssl/certs/example.csr'))

    # Check if the certificate was obtained and saved to the correct location
    self.assertTrue(os.path.exists('/etc/ssl/certs/example.crt'))

    # Check if the private key and certificate were concatenated into a single PEM file
    self.assertTrue(os.path.exists('/etc/ssl/certs/example.pem'))

if __name__ == '__main__':
  unittest.main()
