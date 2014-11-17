class Notie.Collections.NotesCollection extends Backbone.Collection
  model: Notie.Models.NoteModel
  url: '/notes'
  comparator: (note)->
    new Date(note.attributes.updated_at).getTime() * -1

