import {Document, ExternalDocument} from 'pdfjs';


export async function get() {
    // FIXME
    const response = await fetch('/document.pdf')
    const buffer = Buffer.from(await response.arrayBuffer());
    const doc1 = new Document()
    const doc = new ExternalDocument(buffer)
    doc1.addPageOf(1, doc)
    const b1 = await doc1.asBuffer()

    return new Response(b1, { status: 200 })
};