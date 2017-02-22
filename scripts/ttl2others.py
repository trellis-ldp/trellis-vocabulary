#
# This will take a turtle formated RDF file and output a RDF/XML and JSON-LD version of the file.
# Requirements:
#      pip3 install rdflib
#      pip3 install rdflib-jsonld

from __future__ import absolute_import, division, print_function

from rdflib import Graph
from rdflib.serializer import Serializer

import argparse


if __name__ == '__main__':

    parser = argparse.ArgumentParser(description='Takes a turtle formated RDF file and creates a RDF/XML and JSON-LD version of it')
    parser.add_argument('filename', help='Turtle formated RDF file to translate')

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

    filename_base = args.filename
    if '.' in args.filename:
        filename_base = args.filename.split('.')[0]

    tgraph = graph.parse(location=args.filename, format='text/turtle')

    tgraph.serialize(filename_base + '.rdf', format='application/rdf+xml')
    tgraph.serialize(filename_base + '.jsonld', format='json-ld', indent=2, context=context)

