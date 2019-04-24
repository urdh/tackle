# urdh prompt theme, by Simon Sigurdhsson <http://github.com/urdh/>
function fish_right_prompt --description 'Write out the right-hand prompt'
    # Shared settings
    _ifnotset _urdh_theme_vcs_color_clean 'green' '--bold'
    _ifnotset _urdh_theme_vcs_color_staged 'green' '--bold'
    _ifnotset _urdh_theme_vcs_color_invalid 'red' '--bold'
    _ifnotset _urdh_theme_vcs_color_dirty 'yellow' '--bold'
    _ifnotset _urdh_theme_vcs_color_untracked 'red' '--bold'
    _ifnotset _urdh_theme_vcs_color_stash 'cyan' '--bold'
    _ifnotset _urdh_theme_vcs_color_upstream 'black' '--bold'

    # Git prompt settings
    set -g __fish_git_prompt_color_cleanstate $_urdh_theme_vcs_color_clean
    set -g __fish_git_prompt_color_stagedstate $_urdh_theme_vcs_color_staged
    set -g __fish_git_prompt_color_invalidstate $_urdh_theme_vcs_color_invalid
    set -g __fish_git_prompt_color_dirtystate $_urdh_theme_vcs_color_dirty
    set -g __fish_git_prompt_color_untrackedfiles $_urdh_theme_vcs_color_untracked
    set -g __fish_git_prompt_color_stashstate $_urdh_theme_vcs_color_stash
    set -g __fish_git_prompt_color_upstream $_urdh_theme_vcs_color_upstream

    _ifnotset __fish_git_prompt_char_upstream_equal ''
    _ifnotset __fish_git_prompt_char_upstream_ahead '⬘'
    _ifnotset __fish_git_prompt_char_upstream_behind '⬙'
    _ifnotset __fish_git_prompt_char_upstream_diverged '⬥'
    _ifnotset __fish_git_prompt_char_stateseparator ''
    _ifnotset __fish_git_prompt_char_dirtystate '●'
    _ifnotset __fish_git_prompt_char_invalidstate '⦻'
    _ifnotset __fish_git_prompt_char_stagedstate '●'
    _ifnotset __fish_git_prompt_char_untrackedfiles '○'
    _ifnotset __fish_git_prompt_char_cleanstate '✔ '
    _ifnotset __fish_git_prompt_char_stashstate '▣'

    _ifnotset __fish_git_prompt_hide_dirtystate 'true'
    _ifnotset __fish_git_prompt_hide_invalidstate 'true'
    _ifnotset __fish_git_prompt_hide_stagedstate 'true'
    _ifnotset __fish_git_prompt_hide_untrackedfiles 'true'

    set -g __fish_git_prompt_showstashstate 'true'
    set -g __fish_git_prompt_showdirtystate 'true'
    set -g __fish_git_prompt_showuntrackedfiles 'true'
    set -g __fish_git_prompt_show_informative_status 'true'
    set -g __fish_git_prompt_showupstream 'git'

    set -g __fish_git_prompt_shorten_branch_len '0'
    set -g __fish_git_prompt_shorten_branch_char_suffix ''

    # Show the prompt!
    set -l ___vcs (vcprompt -f '%n')
    if test -n "$___vcs"
        switch $___vcs
            case 'git'
                fish_git_prompt '%s'
            case '*'
                set -l ___normal_color (set_color normal)
                set -l ___status (vcprompt -f '%u%m')
                if string match -qr '\+' "$___status"
                    set -l ___dirty_color (set_color $_urdh_theme_vcs_color_dirty)
                    printf '%s●%s' $___dirty_color $___normal_color
                else
                    if string match -qr '\?' "$___status"
                        set -l ___untracked_color  (set_color $_urdh_theme_vcs_color_untracked)
                        printf '%s○%s' $___untracked_color $___normal_color
                    end
                end
        end
    end
end
