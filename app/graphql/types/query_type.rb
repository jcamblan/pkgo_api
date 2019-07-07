# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :generations,
          [Types::GenerationType],
          null: false,
          description: 'Returns generations list'

    field :pokemons,
          [Types::PokemonType],
          null: false,
          description: 'Returns pokemons list' do
      argument :kind, String, required: false
      argument :generation_id, ID, required: false
    end

    field :pokemon, PokemonType, null: false, description: 'show pokemon' do
      argument :pokemon_id, ID, required: true, as: :id
    end

    field :researches, [Types::ResearchType], null: false do
      argument :available, Boolean, required: false
    end
    field :research, ResearchType, null: false do
      argument :research_id, ID, required: true, as: :id
    end

    def generations
      Generation.all
    end

    def pokemons(**args)
      if args
        Pokemon.where(args).order(:nid)
      else
        Pokemon.all.order(:nid)
      end
    end

    def pokemon(id:)
      Pokemon.find(id)
    end

    def research(id:)
      Research.find(id)
    end

    def researches(**args)
      if args
        Research.where(args)
      else
        Research.all
      end
    end
  end
end