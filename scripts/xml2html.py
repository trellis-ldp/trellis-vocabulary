#
# This will convert an RDF/XML file into an HTML file
# Requirements:
#       pip3 install lxml

from __future__ import absolute_import, division, print_function

from lxml import etree

import os
import argparse

if __name__ == '__main__':

    parser = argparse.ArgumentParser(description='Takes a RDF/XML file and convert it with the provided XSLT')
    parser.add_argument('rdf', help='RDF/XML serialized RDF file')
    parser.add_argument('xslt', help='XSLT document')

    args = parser.parse_args()
    basename = os.path.basename(args.rdf)

    doc = etree.parse(args.rdf)
    transform = etree.XSLT(etree.parse(args.xslt))
    print(etree.tostring(transform(doc), pretty_print=True))
