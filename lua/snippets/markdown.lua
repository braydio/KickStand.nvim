local ls = require('luasnip')
local s = ls.snippet
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt

return {
  s(
    'outline',
    fmt(
      [[
# {title}

## Summary
- {summary}

## Goals
- {goal_one}
- {goal_two}

## Sections
1. {section_one}
   - {section_one_notes}
2. {section_two}
   - {section_two_notes}

## Next Steps
- {next_steps}

## References
- {references}
      ]],
      {
        title = i(1, 'Document Title'),
        summary = i(2, 'Key outcomes or context'),
        goal_one = i(3, 'Primary goal'),
        goal_two = i(4, 'Secondary goal'),
        section_one = i(5, 'Section title'),
        section_one_notes = i(6, 'Supporting details'),
        section_two = i(7, 'Next section title'),
        section_two_notes = i(8, 'Supporting details'),
        next_steps = i(9, 'Action items'),
        references = i(10, 'Links or docs'),
      }
    )
  ),
}
