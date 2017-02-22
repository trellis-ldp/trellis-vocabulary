#
# This will take a turtle formated RDF file and output a RDF/XML and JSON-LD version of the file.
# Requirements:
#      pip3 install rdflib
#      pip3 install rdflib-jsonld
#      pip3 install lxml

from __future__ import absolute_import, division, print_function

from rdflib import Graph
from rdflib.serializer import Serializer
from lxml import etree

import argparse
import os


if __name__ == '__main__':

    parser = argparse.ArgumentParser(description='Takes a turtle formated RDF file and creates a RDF/XML and JSON-LD version of it')
    parser.add_argument('filename', help='Turtle formated RDF file to translate')
    parser.add_argument('--xslt', help='The XSLT for generating an HTML document from RDF/XML', default='xslt/rdf2html.xsl')

    args = parser.parse_args()

    graph = Graph()

    context = {
        "ldp": "http://www.w3.org/ns/ldp#",
        "owl": "http://www.w3.org/2002/07/owl#",
        "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
        "trellis": "http://acdc.amherst.edu/ns/trellis#",
        "vann" : "http://purl.org/vocab/vann/",
        "vs": "http://www.w3.org/2003/06/sw-vocab-status/ns#",

        "id": "@id",
        "type": "@type",

        "comment": { "@id": "rdfs:comment", "@language": "en" },
        "domain": { "@id": "rdfs:domain", "@type": "@id" },
        "isDefinedBy": { "@id": "rdfs:isDefinedBy", "@type": "@id" },
        "label": { "@id": "rdfs:label", "@language": "en" },
        "range": { "@id": "rdfs:range", "@type": "@id" },
        "versionInfo": { "@id": "owl:versionInfo" },
        "inverseOf": { "@id": "owl:inverseOf", "@type": "@id" },
        "preferredNamespacePrefix": { "@id": "vann:preferredNamespacePrefix" },
        "preferredNamespaceUri": { "@id": "vann:preferredNamespaceUri" },
        "term_status": { "@id": "vs:term_status" }}

    (basename, ext) = os.path.splitext(os.path.basename(args.filename))

    tgraph = graph.parse(location=args.filename, format='text/turtle')

    tgraph.serialize(basename + '.rdf', format='application/rdf+xml')
    tgraph.serialize(basename + '.jsonld', format='json-ld', indent=2, context=context)

    doc = etree.parse(basename + '.rdf')
    transform = etree.XSLT(etree.parse(args.xslt))
    with open(basename + '.html', 'w') as f:
        f.write(etree.tostring(transform(doc), pretty_print=True));


